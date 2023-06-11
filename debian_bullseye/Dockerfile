FROM debian:bullseye
ADD build.sh /build.sh
ADD cmd.sh /cmd.sh
RUN /build.sh
EXPOSE 443/tcp
CMD ["bash", "-c", "/cmd.sh"]
