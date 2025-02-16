// Masterminter uses this to remove MinterController
// Minter previously assigned allowances will still be valid.

import FiatToken from 0x{{.FiatToken}}
import FiatTokenInterface from 0x{{.FiatTokenInterface}}

transaction (minterController: UInt64 ) {
    prepare(masterMinter: AuthAccount) {
        let mm = masterMinter.borrow<&FiatToken.MasterMinter{FiatTokenInterface.MasterMinter}>(from: FiatToken.MasterMinterStoragePath) 
            ?? panic ("no masterminter resource avaialble");

        mm.removeMinterController(minterController: minterController);
    }
    post {
        FiatToken.getManagedMinter(resourceId: minterController) == nil : "minterController not removed"
    }
}
