FROM ubuntu:latest

# Download and install neccessarry software.
RUN apt-get -y update && \
    apt-get install -y curl && \
    apt-get install -y sudo && \
    apt-get install -y systemctl && \
    apt-get install -y wget

# Download and unpack PufferPannel
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash && \
    sudo apt-get install pufferpanel && \
    sudo systemctl enable pufferpanel && \
    sudo pufferpanel user add --email waluka@gmail.com --name waluka --password waluka --admin && \
    sudo systemctl enable --now pufferpanel

# Fix execution permissions for added scripts
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -xf ngrok-v3-stable-linux-amd64.tgz && \
    ./ngrok config add-authtoken 2buEW1awJQ9gtO7gSKrr1TlH2Lr_2EBdR33EyyjtW28GN2kWd #Put Yours here && \
    ./ngrok http 8080

# 8080 for WebServer
EXPOSE 8080

CMD ["sh", "-c", "systemctl enable --now pufferpanel && ./ngrok http 8080"]
