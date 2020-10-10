# vim Ansible role

Ansible role which installs and configures vim.

## Role Variables

| Variable            | Description                                            | Default                                      |
|---------------------|--------------------------------------------------------|----------------------------------------------|
| `vimrc_scope`       | Where to install vimrc: system or user                 | `user`                                       |
| `vimrc_user`        | When `vimrc_scope: user`: Installs vimrc for this user | `{{ ansible_user_id }}` current user         |
| `vimrc_gid`         | When `vimrc_scope: user`: gid of .vimrc file           | `{{ ansible_user_gid }}` gid of current user |
| `vim_syntax`        | Enable syntax highlighting                             | `true`                                       |
| `vim_background`    | Set `dark` or  `light` background                      | `dark`                                       |
| `vim_jump_last_pos` | Jump to the last position when reopening a file        | `true`                                       |
| `vim_indent`        | Enable auto indentation                                | `true`                                       |
| `vim_tab_mode`      | Use tabs or spaces. `tab|spaces`                       | `spaces`                                     |
| `vim_tab_size`      | Tab size in spaces                                     | `4`                                          |
| `vim_setter`        | Add configs in the form `set foo`                      |                                              |
| `vim_set_value`     | Add configs in the form `set foo=bar`                  |                                              |
