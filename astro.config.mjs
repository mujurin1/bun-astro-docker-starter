// @ts-check
import node from "@astrojs/node";
import react from '@astrojs/react';
import { defineConfig } from 'astro/config';

export default defineConfig({
  // static: 基本は静的, server: 基本はSSR
  output: "static",
  integrations: [react()],
  // サーバーサイドレンダリング時に必要
  // dev環境ではadapterがない場合はnodeで動作するが preview 時は必要
  // ※ preview で動作するアダプターは node のみ
  // 他には vercel 用のアダプターなど環境に合わせて存在する
  adapter: node({
    mode: "standalone",
  }),
});