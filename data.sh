echo "Download ngrok"
wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xvzf ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
chmod +x ngrok
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP 
./ngrok tcp 5000 >/dev/null 2>&1 >/dev/null &

sleep 5

echo "kunes:kunes:N" > CREATEUSERS.TXT
docker run --name RattyDAVE20.04 \
           --privileged=true \
           -p 5000:3389 \
           -e TZ="Europe/London" \
           -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt \
           -dit --restart unless-stopped \
           --shm-size 20g fookam/9013:9987
