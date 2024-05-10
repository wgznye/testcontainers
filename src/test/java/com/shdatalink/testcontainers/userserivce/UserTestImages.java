package com.shdatalink.testcontainers.userserivce;

import org.testcontainers.utility.DockerImageName;

public interface UserTestImages {
    DockerImageName DG_USER_IMAGE = DockerImageName.parse("dg_user:latest");
}
