<script setup lang="ts">
import { KeyRound, LockKeyhole, Plus, Settings, ShieldCheck, WandSparkles } from 'lucide-vue-next'
import BrandLogo from './BrandLogo.vue'
import SyncStatus from './SyncStatus.vue'

const sections = [
  { label: '所有项目', icon: LockKeyhole, active: true },
  { label: '登录账号', icon: ShieldCheck, active: false },
  { label: 'API Key', icon: KeyRound, active: false },
  { label: '密码生成器', icon: WandSparkles, active: false },
  { label: '设置', icon: Settings, active: false },
] as const
</script>

<template>
  <aside class="app-sidebar" aria-label="主导航">
    <BrandLogo />
    <button class="app-sidebar__add" type="button">
      <Plus :size="17" aria-hidden="true" />
      新建项目
    </button>
    <nav>
      <a
        v-for="item in sections"
        :key="item.label"
        href="#"
        :class="{ 'app-sidebar__link--active': item.active }"
        :aria-current="item.active ? 'page' : undefined"
        @click.prevent
      >
        <component :is="item.icon" :size="17" aria-hidden="true" />
        {{ item.label }}
      </a>
    </nav>
    <SyncStatus class="app-sidebar__status" />
  </aside>
</template>

<style scoped>
.app-sidebar {
  display: flex;
  min-height: 100%;
  padding: 24px 18px 18px;
  border-right: 1px solid var(--color-border);
  background: var(--color-surface-subtle);
  flex-direction: column;
}

.app-sidebar__add {
  display: flex;
  min-height: 44px;
  margin: 28px 0 14px;
  padding: 0 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-control);
  align-items: center;
  gap: 9px;
  background: var(--color-surface);
  font-size: 13px;
  font-weight: 600;
}

.app-sidebar nav {
  display: grid;
  gap: 3px;
}

.app-sidebar a {
  display: flex;
  min-height: 44px;
  padding: 0 11px;
  border-radius: 9px;
  align-items: center;
  gap: 10px;
  color: var(--color-text-secondary);
  font-size: 13px;
  text-decoration: none;
}

.app-sidebar a:hover,
.app-sidebar__link--active {
  background: var(--color-surface);
  color: var(--color-text) !important;
}

.app-sidebar__status {
  margin: auto 10px 0;
}
</style>
