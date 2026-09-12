<script setup lang="ts">
import { computed, ref } from 'vue'
import { ExternalLink, KeyRound } from 'lucide-vue-next'
import AppSidebar from '../components/AppSidebar.vue'
import GalleryShell, {
  type PreviewPage,
  type PreviewViewport,
} from '../components/GalleryShell.vue'
import VaultItemList from '../components/VaultItemList.vue'
import { vaultItems } from '../data/demo-data'
import ProductLayout from '../layouts/ProductLayout.vue'

const page = ref<PreviewPage>('login')
const viewport = ref<PreviewViewport>('desktop')

const pageTitles: Readonly<Record<PreviewPage, string>> = {
  login: '登录 KeyNest',
  unlock: '解锁密码库',
  vault: '密码库',
  'login-detail': '登录账号详情',
  'api-key-detail': 'API Key 详情',
  'new-item': '新建项目',
  generator: '密码生成器',
  settings: '设置',
  devices: '设备管理',
}

const title = computed(() => pageTitles[page.value])
</script>

<template>
  <GalleryShell v-model:page="page" v-model:viewport="viewport">
    <ProductLayout v-if="page === 'vault'">
      <template #sidebar><AppSidebar /></template>
      <template #list><VaultItemList :items="vaultItems" selected-id="github-example" /></template>
      <section class="vault-detail">
        <header>
          <span class="vault-detail__mark"><KeyRound :size="22" aria-hidden="true" /></span>
          <div>
            <p>登录账号</p>
            <h2>GitHub</h2>
          </div>
        </header>
        <dl>
          <div><dt>账号</dt><dd>octocat@example.com</dd></div>
          <div><dt>密码</dt><dd class="vault-detail__secret">••••••••••••••••</dd></div>
          <div>
            <dt>网站</dt>
            <dd>github.com <ExternalLink :size="14" aria-label="在新窗口打开" /></dd>
          </div>
        </dl>
      </section>
    </ProductLayout>

    <section v-else class="page-placeholder">
      <span class="page-placeholder__mark" aria-hidden="true"><KeyRound :size="25" /></span>
      <p>KeyNest</p>
      <h2>{{ title }}</h2>
      <span>页面内容将在下一阶段组合</span>
    </section>
  </GalleryShell>
</template>

<style scoped>
.page-placeholder {
  display: flex;
  min-height: 680px;
  padding: 48px 24px;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  text-align: center;
}

.page-placeholder__mark,
.vault-detail__mark {
  display: grid;
  border: 1px solid var(--color-border);
  place-items: center;
  color: var(--color-brand);
}

.page-placeholder__mark {
  width: 52px;
  height: 52px;
  margin-bottom: 22px;
  border-radius: 15px;
}

.page-placeholder p,
.vault-detail p {
  margin: 0 0 6px;
  color: var(--color-text-muted);
  font-size: 12px;
  font-weight: 650;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.page-placeholder h2 {
  margin: 0;
  font-size: clamp(25px, 4vw, 36px);
  letter-spacing: -0.035em;
}

.page-placeholder > span:last-child {
  margin-top: 12px;
  color: var(--color-text-secondary);
  font-size: 13px;
}

.vault-detail {
  padding: 42px clamp(24px, 5vw, 58px);
}

.vault-detail header {
  display: flex;
  padding-bottom: 30px;
  border-bottom: 1px solid var(--color-border);
  align-items: center;
  gap: 16px;
}

.vault-detail__mark {
  width: 48px;
  height: 48px;
  border-radius: 13px;
}

.vault-detail h2 {
  margin: 0;
  font-size: 24px;
  letter-spacing: -0.025em;
}

.vault-detail dl {
  display: grid;
  margin: 30px 0 0;
  gap: 25px;
}

.vault-detail dl div {
  display: grid;
  gap: 7px;
}

.vault-detail dt {
  color: var(--color-text-secondary);
  font-size: 12px;
}

.vault-detail dd {
  display: flex;
  margin: 0;
  align-items: center;
  gap: 7px;
  overflow-wrap: anywhere;
  font-size: 14px;
}

.vault-detail__secret {
  font-family: var(--font-mono);
  letter-spacing: 0.08em;
}

@container product-frame (max-width: 719px) {
  .vault-detail {
    padding: 28px 22px;
  }
}
</style>
