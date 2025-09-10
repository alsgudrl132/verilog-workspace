# 2025-09-10T09:18:36.820773
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_stop_watch")
status = platform.build()

comp = client.get_component(name="app_stop_watch")
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

client.delete_component(name="platform_stop_watch")

platform = client.create_platform_component(name = "platform_stop_watch",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="app_stop_watch")

comp = client.create_app_component(name="app_stop_watch",platform = "$COMPONENT_LOCATION/../platform_stop_watch/export/platform_stop_watch/platform_stop_watch.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="platform_stop_watch")

client.delete_component(name="app_stop_watch")

platform = client.create_platform_component(name = "platform_stop_watch",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stop_watch",platform = "$COMPONENT_LOCATION/../platform_stop_watch/export/platform_stop_watch/platform_stop_watch.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

