# 2025-09-04T09:23:55.191004
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_fnd_cntr",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_btn_fnd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_fnd_cntr",platform = "$COMPONENT_LOCATION/../platform_fnd_cntr/export/platform_fnd_cntr/platform_fnd_cntr.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_fnd_cntr")
status = platform.build()

comp = client.get_component(name="app_fnd_cntr")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="platform_fnd_cntr")

client.delete_component(name="app_fnd_cntr")

platform = client.create_platform_component(name = "platform_fnd_cntr",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_btn_fnd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="fnd_cntr",platform = "$COMPONENT_LOCATION/../platform_fnd_cntr/export/platform_fnd_cntr/platform_fnd_cntr.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="fnd_cntr")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

platform = client.create_platform_component(name = "platform_dht11",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_dht11_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_dht11",platform = "$COMPONENT_LOCATION/../platform_dht11/export/platform_dht11/platform_dht11.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_dht11")
status = platform.build()

comp = client.get_component(name="app_dht11")
comp.build()

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

status = platform.build()

comp.build()

platform = client.get_component(name="platform_dht11")
status = platform.build()

comp = client.get_component(name="app_dht11")
comp.build()

vitis.dispose()

