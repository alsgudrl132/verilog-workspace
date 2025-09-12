# 2025-09-12T10:40:36.048852
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_intc",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_intc_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_intc",platform = "$COMPONENT_LOCATION/../platform_intc/export/platform_intc/platform_intc.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_intc")
status = platform.build()

comp = client.get_component(name="app_intc")
comp.build()

vitis.dispose()

