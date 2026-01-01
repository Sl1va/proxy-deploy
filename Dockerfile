FROM alpine:latest

RUN apk add --no-cache openssh

RUN ssh-keygen -A

COPY authorized_keys /home/proxyuser/.ssh/authorized_keys
COPY sshd_config /etc/ssh/sshd_config
COPY proxyshell.sh /bin/proxyshell

RUN chmod +x /bin/proxyshell

RUN adduser -D -s /bin/proxyshell -H proxyuser && \
    echo "proxyuser:*" | chpasswd -e && \
    mkdir -p /home/proxyuser/.ssh && \
    chmod 700 /home/proxyuser/.ssh

RUN chmod 600 /home/proxyuser/.ssh/authorized_keys && \
    chown -R proxyuser:proxyuser /home/proxyuser && \
    chmod 644 /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd
EXPOSE 22

RUN rm /etc/motd

CMD ["/usr/sbin/sshd", "-D", "-e"]
