set -e

echo -n "" > ./build/env.js
echo "window._ENV={" > ./build/env.js
for key in $(compgen -v | grep ^REACT_APP_); do
  echo "$key:'${!key}'," >> ./build/env.js
done
echo "}" >> ./build/env.js

exec serve -s build