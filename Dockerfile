FROM dart:latest as builder
WORKDIR /server

COPY . .

# Create dart pubspec.yaml

ENV HTTP_PROXY="http://192.168.2.2:7890"
ENV HTTPS_PROXY="http://192.168.2.2:7890"

RUN cd ./example && dart pub get

RUN dart compile exe ./example/example.dart -o server.exe

# Set runtime image
FROM scratch


COPY --from=builder /runtime /

# Copy executable
COPY --from=builder /server/server.exe /server.exe

# Run the executable
CMD ["/server.exe"]