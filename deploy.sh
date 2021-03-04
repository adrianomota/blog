
#!/usr/bin/env bash

echo "start gigalixir Deploy........."
git remote add gigalixir https://git.gigalixir.com/blogelxpro.git
git push -f gigalixir HEAD:refs/heads/master
echo "finish gigalixir Deploy........."


