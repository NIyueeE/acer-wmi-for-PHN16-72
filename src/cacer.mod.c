#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/elfnote-lto.h>
#include <linux/export-internal.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

#ifdef CONFIG_UNWINDER_ORC
#include <asm/orc_header.h>
ORC_HEADER;
#endif

BUILD_SALT;
BUILD_LTO_INFO;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif



static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0x65487097, "__x86_indirect_thunk_rax" },
	{ 0x3213f038, "mutex_unlock" },
	{ 0xcac33cd4, "platform_profile_register" },
	{ 0xe14c7222, "led_classdev_register_ext" },
	{ 0x56b8cd5c, "devm_hwmon_device_register_with_info" },
	{ 0x548d9097, "_dev_err" },
	{ 0xbfe36436, "platform_profile_remove" },
	{ 0xcf33c53b, "led_classdev_unregister" },
	{ 0x525e718d, "backlight_device_unregister" },
	{ 0xd4835ef8, "dmi_check_system" },
	{ 0x7de7bf50, "__acpi_video_get_backlight_type" },
	{ 0xdfc6db83, "input_allocate_device" },
	{ 0x4ce1b8ec, "sparse_keymap_setup" },
	{ 0xf18bdd75, "wmi_install_notify_handler" },
	{ 0xd45da9af, "input_register_device" },
	{ 0x1e498244, "acpi_dev_get_first_match_dev" },
	{ 0xf78d8661, "put_device" },
	{ 0x4658cd45, "input_set_abs_params" },
	{ 0xf52608a9, "__platform_driver_register" },
	{ 0x9a66e6a5, "platform_device_alloc" },
	{ 0xb7b0777c, "platform_device_add" },
	{ 0x7c983a5d, "dmi_walk" },
	{ 0x69ad106e, "input_free_device" },
	{ 0xaba842fe, "wmi_query_block" },
	{ 0x389ee242, "debugfs_create_dir" },
	{ 0xccad6c8c, "debugfs_create_u32" },
	{ 0xe41c7dc3, "platform_device_put" },
	{ 0x7c75434b, "input_set_capability" },
	{ 0x2cf56265, "__dynamic_pr_debug" },
	{ 0x141271bf, "acpi_dev_found" },
	{ 0xcd8ce890, "acpi_format_exception" },
	{ 0xa648e561, "__ubsan_handle_shift_out_of_bounds" },
	{ 0x17b0f8ca, "wmi_get_event_data" },
	{ 0xcc0da561, "sparse_keymap_entry_from_scancode" },
	{ 0x45aebeab, "sparse_keymap_report_event" },
	{ 0x67927a0d, "platform_profile_notify" },
	{ 0xffeedf6a, "delayed_work_timer_fn" },
	{ 0xfde5dcc6, "param_ops_bool" },
	{ 0x88d0e70b, "param_ops_int" },
	{ 0xbdfb6dbb, "__fentry__" },
	{ 0x5b8239ca, "__x86_return_thunk" },
	{ 0x122c3a7e, "_printk" },
	{ 0x6068bedf, "wmi_evaluate_method" },
	{ 0x37a0cba, "kfree" },
	{ 0xf0fdf6cb, "__stack_chk_fail" },
	{ 0x17f341a0, "i8042_lock_chip" },
	{ 0x4fdee897, "i8042_command" },
	{ 0x1b8b95ad, "i8042_unlock_chip" },
	{ 0xfc4152fc, "ec_read" },
	{ 0xc9d4d6d1, "wmi_has_guid" },
	{ 0x83eb21c, "rfkill_unregister" },
	{ 0xdb68bbad, "rfkill_destroy" },
	{ 0x9fa7184a, "cancel_delayed_work_sync" },
	{ 0x54b1fac6, "__ubsan_handle_load_invalid_value" },
	{ 0xd92deb6b, "acpi_evaluate_object" },
	{ 0xb239073e, "input_event" },
	{ 0x286efcfd, "input_unregister_device" },
	{ 0xfa248ff3, "debugfs_remove" },
	{ 0x11e63400, "platform_device_unregister" },
	{ 0x8c850509, "platform_driver_unregister" },
	{ 0x76ae31fd, "wmi_remove_notify_handler" },
	{ 0x1eb9516e, "round_jiffies_relative" },
	{ 0x2d3385d3, "system_wq" },
	{ 0xb2fcb56d, "queue_delayed_work_on" },
	{ 0x8a490c90, "rfkill_set_sw_state" },
	{ 0xcdce87c, "rfkill_set_hw_state_reason" },
	{ 0x9736e89d, "rfkill_alloc" },
	{ 0xff282521, "rfkill_register" },
	{ 0xc708f1fe, "ec_write" },
	{ 0xb59374a0, "backlight_device_register" },
	{ 0x4dfa8d4b, "mutex_lock" },
	{ 0x2273f01b, "module_layout" },
};

MODULE_INFO(depends, "platform_profile,video,sparse-keymap,wmi");


MODULE_INFO(srcversion, "0C00663C2A1AF5442458A39");
