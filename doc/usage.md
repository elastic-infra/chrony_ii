# Usage

If you are fine with using the public NTP servers you can simply include `chrony_ii` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chrony_ii]"
  ]
}
```

If you need to control your configuration use a role.
