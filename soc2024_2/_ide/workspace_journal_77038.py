# 2025-09-02T11:17:58.935845
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_hello",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_hello_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../platform_hello/export/platform_hello/platform_hello.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_hello")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

