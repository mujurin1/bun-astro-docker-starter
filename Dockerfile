# ========== 開発用 Dockerfile ==========
FROM oven/bun:1.2.17 AS dev

# 作業ディレクトリ
WORKDIR /app

# ホストの依存ファイルを先にコピー
COPY bun.lock package.json ./

# bun install は devDependencies も含めてインストールする
RUN bun install

# ソースコードをコピー
COPY . .

# Astro のデフォルトポート
EXPOSE 4321

# ホットリロードを有効にして起動
CMD ["bun", "run", "dev", "--", "--host"]


# ======== 本番ビルドステージ ========
FROM oven/bun:1.2.17 as build

WORKDIR /app

COPY . .

RUN bun install --production && bun run build


# ======== 本番実行用ステージ ========
FROM oven/bun:1.2.17-alpine as production

WORKDIR /app

COPY --from=build /app/dist /app/dist
COPY --from=build /app/package.json /app/bun.lock /app/
RUN bun install --production --no-save

EXPOSE 4321
CMD ["bun", "run", "preview", "--", "--host"]
