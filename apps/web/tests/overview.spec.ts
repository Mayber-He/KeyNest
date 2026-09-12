import { expect, test, type Page, type TestInfo } from '@playwright/test'

const pages = [
  { id: 'login', label: '登录' },
  { id: 'unlock', label: '解锁密码库' },
  { id: 'vault', label: '密码库' },
  { id: 'login-detail', label: '登录详情' },
  { id: 'api-key-detail', label: 'API Key 详情' },
  { id: 'new-item', label: '新建项目' },
  { id: 'generator', label: '密码生成器' },
  { id: 'settings', label: '设置' },
  { id: 'devices', label: '设备管理' },
] as const

const viewports = [
  { name: 'desktop', width: 1440, height: 1000 },
  { name: 'tablet', width: 900, height: 900 },
  { name: 'mobile', width: 390, height: 844 },
] as const

async function expectAccessibleControls(page: Page) {
  const controls = page.locator('button:visible, a:visible, input:visible, textarea:visible, select:visible, [role="button"]:visible')
  const count = await controls.count()
  for (let index = 0; index < count; index += 1) {
    await expect(controls.nth(index), `control ${index + 1} should have an accessible name`).toHaveAccessibleName(/.+/)
  }
}

async function expectNoHorizontalOverflow(page: Page) {
  const overflows = await page.evaluate(() => {
    const root = document.scrollingElement ?? document.documentElement
    const elements = [root, ...Array.from(document.querySelectorAll<HTMLElement>(
      '[data-product-frame], [data-product-frame] .product-layout, [data-product-frame] .devices-view, [data-product-frame] .generator-view, [data-product-frame] .new-item-view, [data-product-frame] .auth-view, [data-product-frame] .unlock-view, [data-product-frame] .item-detail',
    ))]
    return elements
      .filter((element) => element.clientWidth > 0)
      .filter((element) => element.scrollWidth > element.clientWidth)
      .map((element) => ({
        element: element === root ? 'document' : element.className,
        scrollWidth: element.scrollWidth,
        clientWidth: element.clientWidth,
      }))
  })
  expect(overflows).toEqual([])
}

const previewLabels: Record<(typeof viewports)[number]['name'], string> = {
  desktop: '桌面',
  tablet: '平板',
  mobile: '手机',
}

test.describe('overview visual and accessibility checks', () => {
  for (const viewport of viewports) {
    test(`fits ${viewport.name} and names every interactive control`, async ({ page }, testInfo: TestInfo) => {
      await page.setViewportSize({ width: viewport.width, height: viewport.height })
      await page.goto('/overview')
      await page.screenshot({ path: testInfo.outputPath(`overview-${viewport.name}.png`), fullPage: true })

      for (const preview of viewports) {
        await page.getByRole('group', { name: '预览尺寸' }).getByRole('button', { name: previewLabels[preview.name], exact: true }).click()
        await expect(page.locator('.gallery-shell__frame')).toHaveClass(new RegExp('gallery-shell__frame--' + preview.name))
        for (const option of pages) {
          await page.getByRole('navigation', { name: '页面预览' }).getByRole('button', { name: option.label, exact: true }).click()
          await expect(page.locator('[data-page="' + option.id + '"]')).toHaveAttribute('aria-pressed', 'true')
          await expectAccessibleControls(page)
          await expectNoHorizontalOverflow(page)
        }
      }
    })
  }

  test('selects a vault item and switches its detail view', async ({ page }) => {
    await page.goto('/overview')
    await page.getByRole('button', { name: '密码库', exact: true }).click()
    await page.getByRole('button', { name: /OpenAI/ }).click()
    await expect(page.getByRole('heading', { name: 'OpenAI' })).toBeVisible()
  })

  test('hides an API key again after leaving and returning to its page', async ({ page }) => {
    await page.goto('/overview')
    await page.getByRole('button', { name: 'API Key 详情', exact: true }).click()
    const secret = page.locator('.sensitive-field__value')
    await expect(secret).toHaveText('••••••••••••')
    await page.getByRole('button', { name: '显示 API Key' }).click()
    await expect(secret).not.toHaveText('••••••••••••')
    await page.getByRole('button', { name: '登录', exact: true }).click()
    await page.getByRole('button', { name: 'API Key 详情', exact: true }).click()
    await expect(page.locator('.sensitive-field__value')).toHaveText('••••••••••••')
  })

  test('supports canceling and confirming device access revocation', async ({ page }) => {
    await page.goto('/overview')
    await page.getByRole('button', { name: '设备管理', exact: true }).click()
    const revoke = page.getByRole('button', { name: /撤销 示例 iPhone/ })
    await revoke.click()
    await expect(page.getByRole('dialog')).toBeVisible()
    await page.getByRole('button', { name: '取消', exact: true }).click()
    await expect(page.getByRole('dialog')).toHaveCount(0)
    await revoke.click()
    await page.getByRole('button', { name: '确认撤销', exact: true }).click()
    await expect(page.locator('[data-device-id="iphone-example"]')).toContainText('已撤销')
  })

  test('reopens the new-item dialog after closing it', async ({ page }) => {
    await page.goto('/overview')
    await page.getByRole('button', { name: '新建项目', exact: true }).click()
    await page.getByRole('button', { name: '关闭新建项目窗口' }).click()
    await expect(page.getByRole('dialog')).toHaveCount(0)
    await page.getByRole('button', { name: '打开新建项目', exact: true }).click()
    await expect(page.getByRole('dialog', { name: '新建项目' })).toBeVisible()
  })

  test('shows a copy toast in the generator', async ({ page }) => {
    await page.goto('/overview')
    await page.getByRole('button', { name: '密码生成器', exact: true }).click()
    await page.getByRole('button', { name: '复制生成结果' }).click()
    await expect(page.getByRole('status').filter({ hasText: '已复制' })).toBeVisible()
  })
})
