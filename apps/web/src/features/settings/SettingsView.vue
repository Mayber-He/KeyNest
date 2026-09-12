<script setup lang="ts">
import { ref } from 'vue'
import { ChevronRight } from 'lucide-vue-next'
import AppSidebar from '../../components/AppSidebar.vue'
import SyncStatus, { type SyncState } from '../../components/SyncStatus.vue'

const lockOnLeave = ref(true)
const browserFill = ref(false)
const syncState = ref<SyncState>('synced')

const syncOptions: ReadonlyArray<{ value: SyncState; label: string }> = [
  { value: 'synced', label: '已同步' },
  { value: 'syncing', label: '正在同步' },
  { value: 'offline', label: '当前离线' },
  { value: 'conflict', label: '检测到同步冲突' },
]
</script>

<template>
  <div class="settings-view">
    <AppSidebar class="settings-view__sidebar" />
    <main>
      <header>
        <p>偏好设置</p>
        <h2>设置</h2>
      </header>

      <section aria-labelledby="security-settings">
        <h3 id="security-settings">安全</h3>
        <label class="settings-row">
          <span><strong>离开时自动锁定</strong><small>切换到其他页面时锁定密码库</small></span>
          <input v-model="lockOnLeave" type="checkbox" aria-label="离开时自动锁定" />
        </label>
        <button class="settings-row" type="button">
          <span><strong>自动锁定时间</strong><small>5 分钟</small></span>
          <ChevronRight :size="18" aria-hidden="true" />
        </button>
      </section>

      <section aria-labelledby="fill-settings">
        <h3 id="fill-settings">自动填充</h3>
        <label class="settings-row">
          <span><strong>浏览器自动填充</strong><small>在已保存的网站显示填充建议</small></span>
          <input v-model="browserFill" type="checkbox" aria-label="浏览器自动填充" />
        </label>
      </section>

      <section aria-labelledby="sync-settings">
        <h3 id="sync-settings">同步</h3>
        <div class="settings-row">
          <span><strong>密码库状态</strong><small>最近同步：刚刚</small></span>
          <SyncStatus :state="syncState" />
        </div>
        <label class="settings-row">
          <span><strong>同步状态</strong><small>选择当前连接状态</small></span>
          <select v-model="syncState" aria-label="同步状态">
            <option v-for="option in syncOptions" :key="option.value" :value="option.value">{{ option.label }}</option>
          </select>
        </label>
      </section>

      <section aria-labelledby="account-settings">
        <h3 id="account-settings">账户与设备</h3>
        <button class="settings-row" type="button">
          <span><strong>管理已登录设备</strong><small>3 台设备</small></span>
          <ChevronRight :size="18" aria-hidden="true" />
        </button>
      </section>
    </main>
  </div>
</template>

<style scoped>
.settings-view { display: grid; min-height: 680px; grid-template-columns: 220px minmax(0, 1fr); }
.settings-view main { width: min(100%, 720px); padding: 42px clamp(24px, 5vw, 64px); }
.settings-view header p,
.settings-view h2 { margin: 0; }
.settings-view header p { color: var(--color-text-muted); font-size: 12px; font-weight: 650; letter-spacing: .08em; }
.settings-view h2 { margin-top: 5px; font-size: 28px; letter-spacing: -.035em; }
.settings-view section { margin-top: 28px; }
.settings-view h3 { margin: 0 0 8px; color: var(--color-text-secondary); font-size: 12px; font-weight: 650; }
.settings-row { display: flex; width: 100%; min-height: 64px; padding: 10px 0; border: 0; border-top: 1px solid var(--color-border); align-items: center; justify-content: space-between; gap: 18px; background: transparent; text-align: left; }
.settings-row > span { display: grid; gap: 3px; }
.settings-row strong { font-size: 13px; font-weight: 620; }
.settings-row small { color: var(--color-text-secondary); font-size: 12px; }
.settings-row input { width: 20px; height: 20px; flex: none; accent-color: var(--color-brand); }
.settings-row select { min-height: 44px; max-width: 180px; padding: 0 34px 0 10px; border: 1px solid var(--color-border); border-radius: var(--radius-control); background: var(--color-surface); font-size: 12px; }

@container product-frame (max-width: 719px) {
  .settings-view { display: block; }
  .settings-view__sidebar { display: none; }
  .settings-view main { padding: 28px 22px; }
  .settings-row { align-items: flex-start; }
  .settings-row select { max-width: 150px; }
}
</style>
