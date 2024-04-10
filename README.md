# gitea-debianizer

Because there are no official Debian packages of Gitea I created this scripts to
repackage a github release with debpkg. It is even possible from macOS to create
a Debian package!

## Runtime dependencies

* postgress

## Build dependencies

* curl
* xz
* tar
* debpkg (golang)

## Usages

```
# dpkg -i gitea-*.deb
# cp /etc/gitea/app.example.ini /etc/gitea/app.ini
# systemctl enable gitea
# service gitea start
# systemctl status gitea
```
