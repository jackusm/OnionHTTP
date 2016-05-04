# OnionIRC
Docker container for running an HTTP server as a Tor hidden service. Runs great on a [Raspberry Pi](https://www.raspberrypi.org/).

```
git clone https://github.com/jackusm/OnionHTTP.git
```

#### Why is this useful?
You can share the private key of your Tor hidden service within your circle of trust. This provides redundancy in your server as in the event of a disaster anyone that had your private key could rebuild the exact image you were running  and the network would be up and running 100% again.

#### Notes
* [nginx](https://www.nginx.com/) (HTTP Server)
* [Debian Jessie](https://hub.docker.com/_/debian/) (base docker image)
* [Tor](https://www.torproject.org/)
* [Supervisord](http://supervisord.org/) -- this daemon will restart critical services if they are found to not be running as expected.

#### Customize the configuration:
There are some things you will need to modify before you can get your IRC hidden service running.
```
vim conf/hidden_service.conf
```

Change the server name, it must be a FQDN name.

Find this towards the bottom of the file and modify the operator login information:

```
[Operator]
    Name = root
    Password = changeme
```

Modify as you wish. This is the main admin user of the server. **Use strong passwords**!

#### Logging
Currently this is disabled. If you wish to log you can modify the rsyslog configuration found within conf/rsyslog.conf.

#### Build the image:
```
docker build --rm -t onionhttp .
```

#### Run the server:
```
docker run -d -v $(pwd):/var/lib/tor --name onionhttp onionhttp
```

#### Get your onion name:
```
cat ./hidden_service/hostname
```

Remember that your **private key** is in this directory. This is used to identify your host with Tor so you can use the assigned onion address. If this address changes you will need a way to notify the users of this change -- which is difficult. **Do not lose this key!** It is also recommended that you utilize an encrypted filesystem like [eCryptfs](http://ecryptfs.org/).

Connect to your hidden service using the onion domain returned from the last command.
