#!/bin/zsh
set -eu
cd "${0:A:h}"
if command -v node >/dev/null 2>&1; then
  NOVA_NODE_BIN="$(command -v node)"
elif [[ -x /Users/mac/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node ]]; then
  NOVA_NODE_BIN=/Users/mac/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node
else
  print 'Для ИИ-сервера нужен Node.js 22 или новее. Калькулятор index.html работает без него.'
  read -r 'NOVA_PAUSE?Нажмите Enter…'
  exit 1
fi
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  read -r -s 'NOVA_API_SECRET?Введите ключ OpenAI API (ввод скрыт, ключ не сохраняется): '
  print
  export OPENAI_API_KEY="$NOVA_API_SECRET"
  unset NOVA_API_SECRET
fi
if [[ -z "${OPENAI_MODEL:-}" ]]; then
  read -r 'NOVA_MODEL_INPUT?Введите имя доступной вам модели API: '
  export OPENAI_MODEL="$NOVA_MODEL_INPUT"
fi
print 'Не закрывайте окно, пока пользуетесь ИИ. Запросы могут тарифицироваться.'
exec "$NOVA_NODE_BIN" server.mjs
