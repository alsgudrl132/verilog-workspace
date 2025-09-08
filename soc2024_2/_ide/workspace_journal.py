# 2025-09-08T10:31:28.936637
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

platform = client.create_platform_component(name = "platform_txtlcd",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_txtlcd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_txtlcd",platform = "$COMPONENT_LOCATION/../platform_txtlcd/export/platform_txtlcd/platform_txtlcd.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_txtlcd")
status = platform.build()

comp = client.get_component(name="app_txtlcd")
comp.build()

