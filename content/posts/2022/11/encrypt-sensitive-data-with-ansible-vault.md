---
title: "使用 Ansible Vault 加密敏感資料"
date: 2022-11-20T21:07:18+08:00
tags: [ansible]
---

ansible vault 可以將資料加密，保護敏感資料。

可以參考官方: [Encrypting content with Ansible Vault — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

或是中文可以參考 [Vault — ansible中文權威指南 1.0.1 documentation](https://chusiang.github.io/ansible-docs-translate/playbooks_vault.html)

ansible vault 的指令集如下
```bash
$ ansible-vault
usage: ansible-vault [-h] [--version] [-v] {create,decrypt,edit,view,encrypt,encrypt_string,rekey} ...

encryption/decryption utility for Ansible data files

positional arguments:
  {create,decrypt,edit,view,encrypt,encrypt_string,rekey}
    create              Create new vault encrypted file
    decrypt             Decrypt vault encrypted file
    edit                Edit vault encrypted file
    view                View vault encrypted file
    encrypt             Encrypt YAML file
    encrypt_string      Encrypt a string
    rekey               Re-key a vault encrypted file
```


加密的方式可以選擇加密整個檔案或是特定變數，個人覺得使用方法很有彈性，可以搭配自己的情境做選擇。

## 加密檔案

我們先準備一個放有資料庫帳密的 `config.yml` 檔案

```yaml
db:
  username: dev
  password: secret
```

使用 `ansible-vault encrypt` 加密檔案，指令如下
```bash
$ ansible-vault encrypt config.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```

指令會要求你輸入密碼跟確認密碼，輸入後加密就完成了。

加密後的 `config.yml` 如下:
```bash
$ cat config.yml
$ANSIBLE_VAULT;1.1;AES256
31663732653730363438366439663038666136666462396434333830303037373736353238376131
3332663034326465383638386662663530666533613439390a346562623437346137656632323737
31623830316564353034613661323762313738343438663235373662393733666533653462343264
6330366433646566310a313363363665393562623237393939366630346130613338366632373438
31666238653235613939326333343637633361616532663032313762363937306532316530373435
3138343238366438353062333638303738363234393634636439
```

想要看加密的檔案內容，可以用以下指令:
```bash
$ ansible-vault view config.yml
Vault password:
```

指令會要求你輸入密碼，輸入正確的話，就可以看到原始內容

## 加密變數

如果覺得只有一個密碼卻要加密整個檔案很麻煩，可以試試只加密一個變數的方式

假設我們要將密碼 `secret` 加密，並指令 `password` 變數名稱，可以使用以下指令:
```bash
$ ansible-vault encrypt_string secret --name 'password'
New Vault password:
Confirm New Vault password:
Encryption successful
password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          62613436303334623932376565646635643632346364656136636666356233623532613235393138
          3632653136313439323530653239353965643661303166660a303238656537386163613638363935
          35613039653632393939633363333161373861383935393633306462316333643662633766323837
          3966326262613962310a373035366163623862376130373161353733633034613134336135343030
          3834
```
ps. 指令變數名稱的參數 `--name` 是非必要的


## 加密變數搭配 ansible playbook

我們來建立一個簡單的 playbook `play.yml` 來印出解密的密碼，並放入剛剛加密的 password 變數，檔案內容如下:
```yaml
---
- hosts: localhost
  vars:
    password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      62613436303334623932376565646635643632346364656136636666356233623532613235393138
      3632653136313439323530653239353965643661303166660a303238656537386163613638363935
      35613039653632393939633363333161373861383935393633306462316333643662633766323837
      3966326262613962310a373035366163623862376130373161353733633034613134336135343030
      3834
  tasks:
    - name: print password
      ansible.builtin.debug:
        msg: decrypt password is {{password}}
```

接下來我們來執行 playbook，輸入指令時請記得加上 --ask-vault-pass 並跟隨指示輸入密碼，否則會得到失敗的訊息 `{"msg": "Attempting to decrypt but no vault secrets found"}`

執行指令的過程如下:
```bash
$ ansible-playbook play.yml --ask-vault-pass
Vault password:
PLAY [localhost] *************************************************************************

TASK [Gathering Facts] *************************************************************************
ok: [localhost]

TASK [print password] *************************************************************************
ok: [localhost] => {
    "msg": "decrypt password is secret"
}

PLAY RECAP *************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

我們可以看到加密的變數 `password` 成功解密並顯示在畫面上了。

## 使用密碼檔案

vault 密碼不一定要手動輸入，也可以從檔案讀取

```bash
$ echo test > vault_password
```

```bash
$ ansible-playbook play.yml --vault-password-file vault_password
```


## Reference
- [Encrypting content with Ansible Vault — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/vault.html)
- [Vault — ansible中文權威指南 1.0.1 documentation](https://chusiang.github.io/ansible-docs-translate/playbooks_vault.html)
- [30. 怎麼用 Vault 管理敏感資料？ - iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天](https://ithelp.ithome.com.tw/articles/10188119)
