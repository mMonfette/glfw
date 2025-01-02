-- premake5.lua for GLFW
project "GLFW"
    
    -- project specifications
    kind "StaticLib"
    language "C"
    staticruntime "on"

    -- compilation output directories
    targetdir ("../../bin/" .. outputdir .. "/%{prj.name}")
    objdir ("../../bin-obj/" .. outputdir .. "/%{prj.name}")

    -- files common to all systems
    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/context.c",
        "src/egl_context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c",
        "src/osmesa_context.c",
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c",
    }

    -- linux specific source files
    filter "system:linux" 
        files {
            -- Linux Base
            "src/linux_joystick.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/posix_module.c",
            "src/posix_poll.c",

            -- X11 support
            "src/glx_context.c",
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",

            -- Wayland support

            -- "src/wl_init.c",
            -- "src/wl_monitor.c",
            -- "src/wl_window.c",
            -- "src/xkb_unicode.c",
        }

        defines {
            "_GLFW_X11",
            -- "_GLFW_WAYLAND",
        }

    -- macos specific source files
    filter "system:macosx"
        files {
            "src/cocoa_time.c",
            "src/cocoa_joystick.m",
            "src/cocoa_init.m",
            "src/cocoa_monitor.m",
            "src/cocoa_window.m",
            "src/posix_thread.c",
            "src/posix_module.c",
            "src/nsgl_context.m",
        }

        defines {
            "_GLFW_COCOA",
        }

    -- windows specific source files
    filter "system:windows"
        systemversion "latest"

        files {
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_module.c",
            "src/win32_joystick.c",
            "src/win32_init.c",
            "src/win32_monitor.c",
            "src/win32_window.c",
            "src/wgl_context.c",
        }

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter "configurations:debug"
        runtime "rebug"
        symbols "on"

    filter "configurations:release"
		runtime "release"
		optimize "speed"