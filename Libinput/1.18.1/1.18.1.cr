class Target < ISM::Software
    
    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand([   "setup",
                            "--reconfigure",
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddebug-gui=false",
                            "-Dtests=false",
                            "-Ddocumentation=false",
                            "-Dlibwacom=false",
                            ".."],
                            buildDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
