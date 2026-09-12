import { mount } from '@vue/test-utils'
import DevicesView from './DevicesView.vue'

it('requires confirmation before revoking a device', async () => {
  const wrapper = mount(DevicesView)
  const device = () => wrapper.get('[data-device-id="iphone-example"]')

  expect(device().text()).toContain('活跃')

  await device().get('button').trigger('click')
  expect(wrapper.get('[role="dialog"]').text()).toContain('撤销设备访问？')

  await wrapper.get('[role="dialog"]').findAll('button')[0].trigger('click')
  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(device().text()).toContain('活跃')

  await device().get('button').trigger('click')
  await wrapper.get('[role="dialog"]').findAll('button')[1].trigger('click')

  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(device().text()).toContain('已撤销')
  expect(device().find('button').exists()).toBe(false)
})
