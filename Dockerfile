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
    ./ngrok config add-authtoken 2bD4qB4o3Vat74zepiJ5LdXu8Ut_6ak4ncGvEcToiXrUuSzea #Put Yours here && \
    ./ngrok http 8080

# 8080 for WebServer
EXPOSE 8080

CMD ["pufferpanel", "start", "--background"] && \
    ./ngrok http 8080
