-- premake5.lua for GLFW
project "GLFW"
    
    -- project specifications
    kind "StaticLib"
    language "C"
    location "external-libraries/glfw"

    -- compilation output directories
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-obj/" .. outputdir .. "/%{prj.name}")

    -- files common to all systems
    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c",
        "src/osmesa_context.c",
        "src/egl_context.c",
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c",
    }

    -- linux specific source files
    filter "system:linux" 
        files {
            -- Linux Base
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/posix_module.c",
            "src/linux_joystick.c",

            -- X11 support
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/glx_context.c",

            -- Wayland support

            -- "src/wl_init.c",
            -- "src/wl_monitor.c",
            -- "src/wl_window.c",
            -- "src/xkb_unicode.c",
        }

        defines {
            "_GLFW_BUILD_X11",
            -- "GLFW_BUILD_WAYLAND",
        }

    -- macos specific source files
    filter "system:macos"
        files {
            "src/posix_thread.c",
            "src/posix_module.c",
            "src/cocoa_time.c",
            "src/cocoa_joystick.m",
            "src/cocoa_init.m",
            "src/cocoa_monitor.m",
            "src/cocoa_window.m",
            "src/nsgl_context.m",
        }

        defines {
            "_GLFW_BUILD_COCOA",
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
            "_GLFW_BUILD_WIN32",
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
		runtime "Release"
		optimize "speed"