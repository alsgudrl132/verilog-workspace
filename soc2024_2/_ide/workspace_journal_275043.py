# 2025-09-05T15:33:34.160377
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_dht11_fnd")
status = platform.build()

comp = client.get_component(name="app_dht11_fnd")
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

client.delete_component(name="platform_dht11_fnd")

platform = client.create_platform_component(name = "platform_dht11_fnd",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_dht11_fnd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

client.delete_component(name="platform_dht11_fnd")

platform = client.create_platform_component(name = "platform_dht11_fnd",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_dht11_fnd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_dht11_fnd",platform = "$COMPONENT_LOCATION/../platform_dht11_fnd/export/platform_dht11_fnd/platform_dht11_fnd.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp.build()

vitis.dispose()

