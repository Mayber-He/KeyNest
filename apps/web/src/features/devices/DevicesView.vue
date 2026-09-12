<script setup lang="ts">
import { ref } from 'vue'
import { Laptop, Monitor, Smartphone } from 'lucide-vue-next'
import AppButton from '../../components/AppButton.vue'
import AppSidebar from '../../components/AppSidebar.vue'
import ConfirmationDialog from '../../components/ConfirmationDialog.vue'
import SyncStatus from '../../components/SyncStatus.vue'
import { devices } from '../../data/demo-data'

const deviceStates = ref(devices.map((device) => ({ ...device, revoked: false })))
const pendingId = ref<string | null>(null)

function confirmRevoke() {
  const target = deviceStates.value.find((device) => device.id === pendingId.value)
  if (target) target.revoked = true
  pendingId.value = null
}
</script>

<template>
  <div class="devices-view">
    <AppSidebar class="devices-view__sidebar" />
    <main>
      <header class="devices-view__header">
        <div>
          <p class="devices-view__eyebrow">安全</p>
          <h2>设备管理</h2>
          <p>查看可以访问你密码库的设备。</p>
        </div>
        <SyncStatus />
      </header>

      <section aria-labelledby="device-list-title">
        <h3 id="device-list-title">已登录设备</h3>
        <div class="devices-view__list">
          <article
            v-for="device in deviceStates"
            :key="device.id"
            :data-device-id="device.id"
            class="device-row"
          >
            <span class="device-row__icon" aria-hidden="true">
              <Laptop v-if="device.platform.includes('macOS')" :size="21" />
              <Smartphone v-else-if="device.platform.includes('iOS')" :size="21" />
              <Monitor v-else :size="21" />
            </span>
            <div class="device-row__body">
              <div class="device-row__title">
                <h4>{{ device.name }}</h4>
                <span v-if="device.current" class="device-row__current">当前设备</span>
              </div>
              <p>{{ device.platform }} · {{ device.location }}</p>
              <p class="device-row__activity">
                <span :class="{ 'device-row__revoked': device.revoked }">
                  {{ device.revoked ? '已撤销' : '活跃' }}
                </span>
                <span aria-hidden="true">·</span>
                {{ device.lastActive }}
              </p>
            </div>
            <AppButton
              v-if="!device.current && !device.revoked"
              variant="secondary"
              :aria-label="`撤销 ${device.name} 的访问`"
              @click="pendingId = device.id"
            >
              撤销访问
            </AppButton>
          </article>
        </div>
      </section>
    </main>

    <ConfirmationDialog
      v-if="pendingId"
      title="撤销设备访问？"
      description="撤销后，这台设备需要重新登录才能访问密码库。"
      confirm-label="确认撤销"
      @cancel="pendingId = null"
      @confirm="confirmRevoke"
    />
  </div>
</template>

<style scoped>
.devices-view {
  display: grid;
  min-height: 680px;
  grid-template-columns: 220px minmax(0, 1fr);
  background: var(--color-surface);
}

.devices-view main {
  width: min(100%, 820px);
  padding: 42px clamp(24px, 5vw, 64px);
}

.devices-view__header {
  display: flex;
  padding-bottom: 28px;
  border-bottom: 1px solid var(--color-border);
  align-items: flex-start;
  justify-content: space-between;
  gap: 24px;
}

.devices-view__eyebrow,
.devices-view h2,
.devices-view__header p,
.device-row h4,
.device-row p { margin: 0; }

.devices-view__eyebrow {
  color: var(--color-text-muted);
  font-size: 12px;
  font-weight: 650;
  letter-spacing: .08em;
}

.devices-view h2 { margin-top: 5px; font-size: 28px; letter-spacing: -.035em; }
.devices-view__header > div > p:last-child { margin-top: 7px; color: var(--color-text-secondary); font-size: 13px; }
.devices-view h3 { margin: 28px 0 12px; font-size: 14px; }
.devices-view__list { border-top: 1px solid var(--color-border); }

.device-row {
  display: grid;
  min-height: 104px;
  padding: 18px 0;
  border-bottom: 1px solid var(--color-border);
  grid-template-columns: 44px minmax(0, 1fr) auto;
  align-items: center;
  gap: 14px;
}

.device-row__icon {
  display: grid;
  width: 44px;
  height: 44px;
  border: 1px solid var(--color-border);
  border-radius: 12px;
  place-items: center;
  color: var(--color-text-secondary);
}

.device-row__title { display: flex; align-items: center; gap: 9px; }
.device-row h4 { font-size: 14px; }
.device-row p { margin-top: 4px; color: var(--color-text-secondary); font-size: 12px; }
.device-row__current { padding: 2px 7px; border-radius: 999px; background: var(--color-surface-subtle); color: var(--color-text-secondary); font-size: 11px; }
.device-row__activity { display: flex; gap: 6px; }
.device-row__activity > span:first-child { color: #237a45; font-weight: 600; }
.device-row__activity .device-row__revoked { color: #9a3412; }

@container product-frame (max-width: 719px) {
  .devices-view { display: block; }
  .devices-view__sidebar { display: none; }
  .devices-view main { padding: 28px 22px; }
  .devices-view__header { align-items: flex-start; flex-direction: column; gap: 8px; }
  .device-row { grid-template-columns: 44px minmax(0, 1fr); }
  .device-row .app-button { grid-column: 2; justify-self: start; }
}
</style>
