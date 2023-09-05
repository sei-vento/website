# zoonect/ventoventures-app

## Development

Setup commands:

    cd ventoventures-app
    sh .ops/gen-dev-envs.sh
    yarn
    mix deps.get
    mix compile
    NODE_OPTIONS=--openssl-legacy-provider mix fermo.build
    NODE_OPTIONS=--openssl-legacy-provider mix fermo.live

---
