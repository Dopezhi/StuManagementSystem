package per.stusystem.service;

import org.springframework.stereotype.Service;

@Service
public class SystemService {
    public boolean systemLogin(String systemId,String pwd) {
        if(systemId.equals("888")&&pwd.equals("888")) {
            return true;
        }else {
            return false;
        }
    }
}
