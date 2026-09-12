<script setup lang="ts">
import { Monitor, Smartphone, Tablet } from 'lucide-vue-next'

export type PreviewPage =
  | 'login'
  | 'unlock'
  | 'vault'
  | 'login-detail'
  | 'api-key-detail'
  | 'new-item'
  | 'generator'
  | 'settings'
  | 'devices'

export type PreviewViewport = 'desktop' | 'tablet' | 'mobile'

defineProps<{
  page: PreviewPage
  viewport: PreviewViewport
}>()

const emit = defineEmits<{
  'update:page': [page: PreviewPage]
  'update:viewport': [viewport: PreviewViewport]
}>()

const pages: ReadonlyArray<{ id: PreviewPage; label: string }> = [
  { id: 'login', label: '登录' },
  { id: 'unlock', label: '解锁密码库' },
  { id: 'vault', label: '密码库' },
  { id: 'login-detail', label: '登录详情' },
  { id: 'api-key-detail', label: 'API Key 详情' },
  { id: 'new-item', label: '新建项目' },
  { id: 'generator', label: '密码生成器' },
  { id: 'settings', label: '设置' },
  { id: 'devices', label: '设备管理' },
]

const viewports: ReadonlyArray<{
  id: PreviewViewport
  label: string
  icon: typeof Monitor
}> = [
  { id: 'desktop', label: '桌面', icon: Monitor },
  { id: 'tablet', label: '平板', icon: Tablet },
  { id: 'mobile', label: '手机', icon: Smartphone },
]
</script>

<template>
  <section class="gallery-shell">
    <header class="gallery-shell__header">
      <div>
        <p class="gallery-shell__eyebrow">网页端</p>
        <h1>KeyNest 界面概览</h1>
      </div>
      <div class="gallery-shell__viewports" aria-label="预览尺寸">
        <button
          v-for="option in viewports"
          :key="option.id"
          type="button"
          :aria-pressed="viewport === option.id"
          :title="option.label"
          @click="emit('update:viewport', option.id)"
        >
          <component :is="option.icon" :size="17" aria-hidden="true" />
          <span>{{ option.label }}</span>
        </button>
      </div>
    </header>

    <nav class="gallery-shell__pages" aria-label="页面预览">
      <button
        v-for="option in pages"
        :key="option.id"
        type="button"
        :data-page="option.id"
        :aria-pressed="page === option.id"
        @click="emit('update:page', option.id)"
      >
        {{ option.label }}
      </button>
    </nav>

    <div class="gallery-shell__stage">
      <div
        data-product-frame
        :class="['gallery-shell__frame', `gallery-shell__frame--${viewport}`]"
      >
        <slot />
      </div>
    </div>
  </section>
</template>

<style scoped>
.gallery-shell {
  min-height: 100vh;
  padding: 32px clamp(16px, 4vw, 56px) 56px;
  background: var(--color-surface-subtle);
}

.gallery-shell__header {
  display: flex;
  width: min(1180px, 100%);
  margin: 0 auto;
  align-items: flex-end;
  justify-content: space-between;
  gap: 24px;
}

.gallery-shell__eyebrow {
  margin: 0 0 4px;
  color: var(--color-text-muted);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.13em;
  text-transform: uppercase;
}

.gallery-shell h1 {
  margin: 0;
  font-size: clamp(24px, 3vw, 34px);
  font-weight: 680;
  letter-spacing: -0.035em;
}

.gallery-shell__viewports,
.gallery-shell__pages {
  display: flex;
  align-items: center;
}

.gallery-shell__viewports {
  gap: 4px;
  padding: 4px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-control);
  background: var(--color-surface);
}

.gallery-shell__viewports button,
.gallery-shell__pages button {
  min-height: 36px;
  border: 0;
  background: transparent;
  color: var(--color-text-secondary);
  font-size: 13px;
}

.gallery-shell__viewports button {
  display: inline-flex;
  padding: 0 10px;
  border-radius: 7px;
  align-items: center;
  gap: 7px;
}

.gallery-shell__viewports button[aria-pressed='true'] {
  background: var(--color-surface-subtle);
  color: var(--color-text);
  font-weight: 600;
}

.gallery-shell__pages {
  width: min(1180px, 100%);
  margin: 22px auto 16px;
  gap: 4px;
  overflow-x: auto;
  scrollbar-width: thin;
}

.gallery-shell__pages button {
  flex: none;
  padding: 0 12px;
  border-radius: 9px;
  white-space: nowrap;
}

.gallery-shell__pages button:hover,
.gallery-shell__pages button[aria-pressed='true'] {
  background: var(--color-surface);
  color: var(--color-text);
}

.gallery-shell__pages button[aria-pressed='true'] {
  box-shadow: inset 0 0 0 1px var(--color-border);
  font-weight: 600;
}

.gallery-shell__stage {
  display: flex;
  min-height: 680px;
  align-items: flex-start;
  justify-content: center;
}

.gallery-shell__frame {
  width: 100%;
  min-height: 680px;
  overflow: hidden;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-container);
  background: var(--color-surface);
  box-shadow: var(--shadow-float);
  container-name: product-frame;
  container-type: inline-size;
  transition: width 180ms ease;
}

.gallery-shell__frame--desktop {
  max-width: 1180px;
}

.gallery-shell__frame--tablet {
  max-width: 900px;
}

.gallery-shell__frame--mobile {
  max-width: 390px;
}

@media (max-width: 719px) {
  .gallery-shell {
    padding: 20px 12px 32px;
  }

  .gallery-shell__header {
    align-items: flex-start;
    flex-direction: column;
  }

  .gallery-shell__viewports span {
    position: absolute;
    width: 1px;
    height: 1px;
    overflow: hidden;
    clip: rect(0 0 0 0);
  }
}

@media (prefers-reduced-motion: reduce) {
  .gallery-shell__frame {
    transition: none;
  }
}
</style>
