# 2025-09-04T16:07:47.350548
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_dht11")
status = platform.build()

status = platform.build()

comp = client.get_component(name="app_dht11")
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

client.delete_component(name="platform_dht11")

client.delete_component(name="app_dht11")

platform = client.create_platform_component(name = "platform_dht11",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_dht11_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_dht11",platform = "$COMPONENT_LOCATION/../platform_dht11/export/platform_dht11/platform_dht11.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

