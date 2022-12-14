#
#  Copyright (c) 2021, The OpenThread Commissioner Authors.
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. Neither the name of the copyright holder nor the
#     names of its contributors may be used to endorse or promote products
#     derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#

add_definitions(-D_XOPEN_SOURCE)

add_library(commissioner-app
    commissioner_app.cpp
    commissioner_app.hpp
    border_agent.cpp
    border_agent.hpp
    br_discover.cpp
    br_discover.hpp
    file_logger.cpp
    file_logger.hpp
    file_util.cpp
    file_util.hpp
    json.cpp
    json.hpp
    logger_util.hpp
    sys_logger.cpp
    sys_logger.hpp
    mdns_handler.hpp
    mdns_handler.cpp
)

target_link_libraries(commissioner-app
    PUBLIC
        commissioner
        commissioner-common
    PRIVATE
        fmt::fmt
        mdns
        nlohmann_json::nlohmann_json
)

target_include_directories(commissioner-app
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src
)

install(DIRECTORY etc/commissioner
        FILE_PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
        DESTINATION etc
)

if (BUILD_SHARED_LIBS)
    install(TARGETS commissioner-app
            LIBRARY DESTINATION lib
            ARCHIVE DESTINATION lib
    )
endif()

if (OT_COMM_TEST)
    add_library(ut-gtest-main OBJECT cli/gmock_main.cpp)

    target_include_directories(ut-gtest-main
        PRIVATE
            ${PROJECT_SOURCE_DIR}/third_party/googletest/repo/googletest/include
    )

    add_executable(commissioner-app-test
        $<TARGET_OBJECTS:ut-gtest-main>
        cli/console.cpp
        commissioner_app_test.cpp
        file_util.cpp
        file_util_test.cpp
        json_test.cpp
        ${PROJECT_SOURCE_DIR}/src/app/border_agent.cpp
        ${PROJECT_SOURCE_DIR}/src/app/file_logger.cpp
        ${PROJECT_SOURCE_DIR}/src/app/json.cpp
        ${PROJECT_SOURCE_DIR}/src/common/address.cpp
        ${PROJECT_SOURCE_DIR}/src/common/error.cpp
        ${PROJECT_SOURCE_DIR}/src/common/time.cpp
        ${PROJECT_SOURCE_DIR}/src/common/utils.cpp
        ${PROJECT_SOURCE_DIR}/src/library/network_data.cpp
        $<TARGET_OBJECTS:commissioner-ps-test>
    )

    target_link_libraries(commissioner-app-test
        fmt::fmt
        gtest
        mdns
        persistent-storage
        readline
    )

    set_target_properties(commissioner-app-test
        PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/tests"
    )

    target_include_directories(commissioner-app-test
        PRIVATE
            ${PROJECT_SOURCE_DIR}/include
            ${PROJECT_SOURCE_DIR}/src
            ${PROJECT_SOURCE_DIR}/third_party/googletest/repo/googletest/include
            ${PROJECT_SOURCE_DIR}/third_party/googletest/repo/googlemock/include
            $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/third_party/fmtlib/repo/include>
            $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/third_party/json/repo/single_include>
    )

endif()

add_subdirectory(cli)
add_subdirectory(ps)
