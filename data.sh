echo "Download ngrok"
wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xvzf ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
chmod +x ngrok
./ngrok authtoken ${{ github.event.inputs.auth }}
./ngrok tcp 5000 >/dev/null 2>&1 >/dev/null &

sleep 5
MYDOCKER=docker$(shuf -i 10000000-99999999 -n 1)
echo "kunes:kunes:N" > CREATEUSERS.TXT
docker run --name $MYDOCKER \
           --privileged=true \
           -p 5000:3389 \
           -e TZ="Asia/Jakarta" \
           -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt \
           -dit --restart unless-stopped \
           --shm-size 20g fookam/9013:9987
