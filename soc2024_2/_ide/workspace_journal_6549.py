# 2025-09-09T15:30:22.211784
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_stop_watch",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stop_watch",platform = "$COMPONENT_LOCATION/../platform_stop_watch/export/platform_stop_watch/platform_stop_watch.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_stop_watch")
status = platform.build()

comp = client.get_component(name="app_stop_watch")
comp.build()

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

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

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../project_9/soc_stop_watch_wrapper.xsa")

status = platform.build()

client.delete_component(name="app_stop_watch")

client.delete_component(name="platform_stop_watch")

platform = client.create_platform_component(name = "platform_stop_watch",hw_design = "$COMPONENT_LOCATION/../../project_9/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stop_watch",platform = "$COMPONENT_LOCATION/../platform_stop_watch/export/platform_stop_watch/platform_stop_watch.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp.build()

vitis.dispose()

