# 2025-09-02T14:05:07.994774
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_led_sw",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_led_sw_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_led_sw",platform = "$COMPONENT_LOCATION/../platform_led_sw/export/platform_led_sw/platform_led_sw.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

comp = client.get_component(name="app_led_sw")
status = comp.clean()

platform = client.get_component(name="platform_led_sw")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

