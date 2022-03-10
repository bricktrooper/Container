FROM ubuntu:20.04

ARG USER=user

COPY password.txt /password.txt
COPY .prompt /.prompt

RUN useradd -m $USER && \
	passwd $USER < /password.txt && \
	rm /password.txt && \
	usermod -aG sudo $USER && \
	mv /.prompt /home/$USER/.prompt && \
	ln -s /home/$USER/.prompt /root/.prompt && \
	echo "source ~/.prompt" >> /home/$USER/.bashrc && \
	echo "source ~/.prompt" >> /root/.bashrc && \
	apt update -y && \
	apt install -y \
		sudo \
		git

# Run the container as 'user'.
# Everything before this point is run as 'root'.
WORKDIR /home/$USER
USER $USER
