# 2025-09-08T09:40:08.381908
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_dht11_iic",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_dht11_iic_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_dht11_iic",platform = "$COMPONENT_LOCATION/../platform_dht11_iic/export/platform_dht11_iic/platform_dht11_iic.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

platform = client.get_component(name="platform_dht11")
status = platform.build()

comp = client.get_component(name="app_dht11")
comp.build()

vitis.dispose()

