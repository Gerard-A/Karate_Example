package examples.check_location;

import com.intuit.karate.junit5.Karate;

class CheckLocationRunner {
    
    @Karate.Test
    Karate testCheckLocation() {
        return Karate.run("checklocation").relativeTo(getClass());
    }    

}
