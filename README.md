# saltstack


## Minion

### Docker
```bash
pip install docker docker-compose
```
On error : Cannot uninstall 'requests'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
```bash
pip install docker docker-compose --no-deps
```
