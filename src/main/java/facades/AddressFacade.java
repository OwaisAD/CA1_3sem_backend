package facades;

import dtos.AddressDTO;
import entities.Address;
import entities.CityInfo;
import utils.EMF_Creator;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 *
 * Rename Class to a relevant name Add add relevant facade methods
 */
public class AddressFacade {

    private static AddressFacade instance;
    private static EntityManagerFactory emf;

    //Private Constructor to ensure Singleton
    private AddressFacade() {}
    
    /**
     * 
     * @param _emf
     * @return an instance of this facade class.
     */
    public static AddressFacade getAddressFacade(EntityManagerFactory _emf) {
        if (instance == null) {
            emf = _emf;
            instance = new AddressFacade();
        }
        return instance;
    }

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }


    public AddressDTO create(AddressDTO ad){
        Address address = new Address(ad);

        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(address);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return new AddressDTO(address);
    }

    public static CityInfo getCityInfoByZipCode(int zipCode) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<CityInfo> query = em.createQuery("SELECT ci FROM CityInfo ci WHERE ci.zipCode = :zip", CityInfo.class);
            query.setParameter("zip", zipCode);
            List<CityInfo> cityList = query.getResultList();
            return cityList.get(0);
        } finally {
            em.close();
        }
    }

    public List<Address> getAllAddressesByZipCode(int zipCode) {
        int cityInfoId = getCityInfoByZipCode(zipCode).getId();

        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Address> query = em.createQuery("select a from Address a join a.cityinfo ac where ac.id= :cityinfoid", Address.class);
            query.setParameter("cityinfoid", cityInfoId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static Address getAddressById(int addressId) {
        EntityManager em = emf.createEntityManager();
        try {
            Address address = em.find(Address.class, addressId);
            return address;
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        emf = EMF_Creator.createEntityManagerFactory();
        //PersonFacade pf = getPersonFacade(emf);
        AddressFacade addressFacade = getAddressFacade(emf);
        //System.out.println(addressFacade.getCityInfoByZipCode(2800));
        System.out.println(getAddressById(1));

    }


}