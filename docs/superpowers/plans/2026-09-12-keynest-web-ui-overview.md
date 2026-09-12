# KeyNest Vue Web UI Overview Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a runnable Vue 3 high-fidelity UI gallery covering all nine approved KeyNest desktop screens.

**Architecture:** Create `apps/web` as a Vite Vue/TypeScript app. Route-level views compose focused shared components and read synthetic fixtures from one module; a gallery shell controls page and viewport selection without leaking gallery controls into product screens.

**Tech Stack:** Vue 3, TypeScript, Vite, Vue Router, Vitest, Vue Test Utils, Lucide Vue Next.

---

### Task 1: Scaffold the Web App

**Files:**
- Create: `apps/web/package.json`
- Create: `apps/web/index.html`
- Create: `apps/web/tsconfig.json`
- Create: `apps/web/vite.config.ts`
- Create: `apps/web/src/main.ts`
- Create: `apps/web/src/App.vue`
- Create: `apps/web/src/router/index.ts`
- Test: `apps/web/src/App.test.ts`

- [ ] **Step 1: Write the failing shell test**

```ts
import { mount } from '@vue/test-utils'
import App from './App.vue'

it('renders the KeyNest gallery title', () => {
  expect(mount(App).text()).toContain('KeyNest 界面概览')
})
```

- [ ] **Step 2: Run `npm install && npm test -- --run` in `apps/web`**

Expected: FAIL because the Vue project and `App.vue` do not exist yet.

- [ ] **Step 3: Create the minimal Vite app and router**

Use scripts `dev`, `build`, `test`, and `typecheck`; dependencies are Vue, Vue Router and Lucide Vue Next, with Vite, TypeScript, Vitest, jsdom and Vue Test Utils as development dependencies. `App.vue` must render `KeyNest 界面概览` and `<RouterView />`; the initial route is `/overview`.

- [ ] **Step 4: Run `npm test -- --run && npm run typecheck && npm run build`**

Expected: all commands exit 0 and Vite creates `apps/web/dist`.

- [ ] **Step 5: Commit**

```bash
git add apps/web
git commit -m "build(web): scaffold Vue UI overview"
```

### Task 2: Design Tokens and Shared Components

**Files:**
- Create: `apps/web/src/styles/tokens.css`
- Create: `apps/web/src/styles/base.css`
- Create: `apps/web/src/components/BrandLogo.vue`
- Create: `apps/web/src/components/AppButton.vue`
- Create: `apps/web/src/components/AppInput.vue`
- Create: `apps/web/src/components/SensitiveField.vue`
- Create: `apps/web/src/components/AppToast.vue`
- Test: `apps/web/src/components/SensitiveField.test.ts`

- [ ] **Step 1: Write the failing sensitive-field test**

```ts
import { mount } from '@vue/test-utils'
import SensitiveField from './SensitiveField.vue'

it('hides, reveals, and hides a secret again', async () => {
  const wrapper = mount(SensitiveField, { props: { label: 'API Key', value: 'sk-public-example' } })
  expect(wrapper.text()).not.toContain('sk-public-example')
  await wrapper.get('[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain('sk-public-example')
  await wrapper.get('[aria-label="隐藏 API Key"]').trigger('click')
  expect(wrapper.text()).not.toContain('sk-public-example')
})
```

- [ ] **Step 2: Run `npm test -- --run src/components/SensitiveField.test.ts`**

Expected: FAIL because `SensitiveField.vue` is absent.

- [ ] **Step 3: Implement tokens and components**

Define the approved colors, 8/10/12/14/18/24px radii, restrained shadow, system Chinese font stack, monospace secret stack and visible `:focus-visible`. `SensitiveField` owns only ephemeral reveal state and emits `copy`; `AppToast` uses `role="status"`.

- [ ] **Step 4: Run the component test and typecheck**

Run: `npm test -- --run src/components/SensitiveField.test.ts && npm run typecheck`  
Expected: PASS and exit 0.

- [ ] **Step 5: Commit**

```bash
git add apps/web/src
git commit -m "feat(web): add KeyNest design system primitives"
```

### Task 3: Fixtures, Gallery Shell, and Responsive Product Layout

**Files:**
- Create: `apps/web/src/data/demo-data.ts`
- Create: `apps/web/src/components/GalleryShell.vue`
- Create: `apps/web/src/components/AppSidebar.vue`
- Create: `apps/web/src/components/VaultItemList.vue`
- Create: `apps/web/src/layouts/ProductLayout.vue`
- Create: `apps/web/src/views/OverviewView.vue`
- Test: `apps/web/src/views/OverviewView.test.ts`

- [ ] **Step 1: Write the failing navigation test**

```ts
it('switches the preview without putting gallery copy inside the product frame', async () => {
  const wrapper = mount(OverviewView)
  await wrapper.get('[data-page="vault"]').trigger('click')
  expect(wrapper.get('[data-product-frame]').text()).toContain('密码库')
  expect(wrapper.get('[data-product-frame]').text()).not.toContain('界面概览')
})
```

- [ ] **Step 2: Run the test and confirm it fails**

Run: `npm test -- --run src/views/OverviewView.test.ts`  
Expected: FAIL because the overview view is absent.

- [ ] **Step 3: Implement the fixture and layout boundary**

Create typed fixtures for GitHub, OpenAI, Google and three devices. Implement a gallery toolbar outside `[data-product-frame]`. At widths above 1100px render sidebar/list/detail; from 720–1099px render sidebar/main; below 720px render one product column.

- [ ] **Step 4: Run the view test**

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add apps/web/src
git commit -m "feat(web): add overview shell and responsive layout"
```

### Task 4: Authentication and Vault Views

**Files:**
- Create: `apps/web/src/features/auth/LoginView.vue`
- Create: `apps/web/src/features/unlock/UnlockView.vue`
- Create: `apps/web/src/features/vault/VaultView.vue`
- Create: `apps/web/src/features/item/LoginDetail.vue`
- Create: `apps/web/src/features/item/ApiKeyDetail.vue`
- Test: `apps/web/src/features/item/ApiKeyDetail.test.ts`

- [ ] **Step 1: Write the failing API Key behavior test**

Mount the view, assert the key is initially hidden, reveal it, emit navigation through the supplied callback, and assert it is hidden after remount.

- [ ] **Step 2: Run the focused test**

Run: `npm test -- --run src/features/item/ApiKeyDetail.test.ts`  
Expected: FAIL because the views are absent.

- [ ] **Step 3: Implement the five approved views**

Use only Chinese interface copy, except approved product data and terms. Keep authentication pages borderless and centered; render the vault as master/detail; show destructive actions as quiet red text.

- [ ] **Step 4: Run all tests and typecheck**

Run: `npm test -- --run && npm run typecheck`  
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add apps/web/src/features
git commit -m "feat(web): add auth and vault preview screens"
```

### Task 5: Remaining Screens and Feedback States

**Files:**
- Create: `apps/web/src/features/item/NewItemDialog.vue`
- Create: `apps/web/src/features/generator/GeneratorView.vue`
- Create: `apps/web/src/features/settings/SettingsView.vue`
- Create: `apps/web/src/features/devices/DevicesView.vue`
- Create: `apps/web/src/components/SyncStatus.vue`
- Test: `apps/web/src/features/devices/DevicesView.test.ts`

- [ ] **Step 1: Write a failing device-revocation confirmation test**

Assert that clicking `撤销访问` opens a dialog, cancel keeps the device, and confirm changes its visible status to `已撤销`.

- [ ] **Step 2: Run the focused test and confirm failure**

Run: `npm test -- --run src/features/devices/DevicesView.test.ts`.

- [ ] **Step 3: Implement the four screens and sync variants**

The generator controls length and five switches; the dialog covers login and API Key fields; settings uses approved groups; devices distinguishes the current device. Add `已同步`, `正在同步`, `当前离线`, and `检测到同步冲突` variants.

- [ ] **Step 4: Run tests, typecheck, and build**

Run: `npm test -- --run && npm run typecheck && npm run build`  
Expected: all exit 0.

- [ ] **Step 5: Commit**

```bash
git add apps/web/src
git commit -m "feat(web): complete desktop UI overview screens"
```

### Task 6: Visual and Accessibility Verification

**Files:**
- Create: `apps/web/tests/overview.spec.ts`
- Modify: `apps/web/src/styles/base.css`

- [ ] **Step 1: Add browser checks**

At 1440×1000, 900×900 and 390×844, visit `/overview`, select every screen, assert no horizontal overflow, and assert every interactive element has an accessible name.

- [ ] **Step 2: Run `npm run test:e2e`**

Expected: initial failures identify any overflow or missing names.

- [ ] **Step 3: Make only the CSS and labeling fixes reported by the checks**

- [ ] **Step 4: Run `npm test -- --run && npm run typecheck && npm run build && npm run test:e2e`**

Expected: all checks pass; capture the overview at all three widths for final visual inspection.

- [ ] **Step 5: Commit**

```bash
git add apps/web
git commit -m "test(web): verify responsive accessible UI overview"
```

