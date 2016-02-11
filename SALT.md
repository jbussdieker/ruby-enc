/etc/salt/master.d/enc.conf
```yaml
master_tops:
  ext_nodes: enc-ext-nodes
ext_pillar:
  - puppet: enc-ext-nodes
```

/usr/bin/enc-ext-nodes
```bash
#!/bin/bash
curl --max-time 2 -s "http://ruby-enc:3000/nodes/$1.yaml"
```
