package facades;

import dtos.HobbyDTO;
import dtos.PersonDTO;
import entities.Hobby;
import entities.Person;
import utils.EMF_Creator;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * Rename Class to a relevant name Add add relevant facade methods
 */
public class HobbyFacade {

    private static HobbyFacade instance;
    private static EntityManagerFactory emf;

    //Private Constructor to ensure Singleton
    private HobbyFacade() {}
    
    /**
     * 
     * @param _emf
     * @return an instance of this facade class.
     */
    public static HobbyFacade getHobbyFacade(EntityManagerFactory _emf) {
        if (instance == null) {
            emf = _emf;
            instance = new HobbyFacade();
        }
        return instance;
    }

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public HobbyDTO create(HobbyDTO hd){
        //Person person = new Person(pd.getEmail(), pd.getFirstName(), pd.getLastName(), pd.getPhone(), pd.getAddress(), pd.getHobbies());
        Hobby hobby = new Hobby(hd.getWikiLink(), hd.getName(), hd.getCategory(), hd.getType(), hd.getDescription(), hd.getPeople());
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(hobby);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return new HobbyDTO(hobby);
    }

    
    public static void main(String[] args) {
        emf = EMF_Creator.createEntityManagerFactory();
        //PersonFacade fe = getFacadeExample(emf);

    }

}
