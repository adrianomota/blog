
#!/usr/bin/env bash

echo "start gigalixir Deploy........."
git remote add gigalixir https://git.gigalixir.com/blogelxpro.git
git push gigalixir HEAD:master --verbose
echo "finish gigalixir Deploy........."


