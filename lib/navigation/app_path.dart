abstract class AppPath {}

class UndefinedPath extends AppPath {}

abstract class MainPath extends AppPath {}

class LaunchPath extends MainPath {}

class HomePath extends LaunchPath {}

class KeyExampleOneLayerReplacementPath extends HomePath {}

class KeyExampleSubtreeReplacementPath
    extends KeyExampleOneLayerReplacementPath {}

class KeyExampleLocalKeysPath extends KeyExampleSubtreeReplacementPath {}

class KeyExamplePageStorageKeyPath extends KeyExampleSubtreeReplacementPath {}

class KeyExampleGlobalKeyPath extends KeyExamplePageStorageKeyPath {}
