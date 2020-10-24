import java.sql.*;
import java.util.Locale;

//potrebno e dopolnitelno da go simnete i postgresql driver fajlot, da go stavite vo folderot na aplikacijata i da go dodadete kako external library

public class Bazi {


	//funkcijata se povikuva od main
	public static void bazaConnect() {

		String baza_DRIVER = "org.postgresql.Driver";
		String baza_STRING = "jdbc:postgresql://localhost:5435/ime na bazata";
		String baza_USERNAME = "username do bazata";
		String baza_PASSWORD = "pass do bazata";



		Locale.setDefault(Locale.ENGLISH); // Vazhno e bidejkji  treba da znae kakvi poraki da pojavuva


		//primerot se konektira do bazata, gi lista site Prodavnici vo nadvoresniot ciklus, 
		//a vo vnatresniot, za sekoja prodavnica, gi zema i gi lista dodatocite koi se prodavaat vo nea.
		try {


			Driver driver = (Driver) Class.forName(baza_DRIVER).newInstance();

			Connection konekcija = DriverManager.getConnection(baza_STRING,
					baza_USERNAME, baza_PASSWORD);


			PreparedStatement statement = konekcija.prepareStatement(
					"SELECT Ime,id_prodavnica FROM prodavnica.prodavnica");

			ResultSet listaProdavnica = statement.executeQuery();

			boolean isEmpty = !listaProdavnica.next();
			boolean hasData = !isEmpty;
			while (hasData) {
				String idProdavnica=listaProdavnica.getString("id_prodavnica");
				int idProdavnicaInt=Integer.parseInt(idProdavnica);


				System.out.println("Prodavnica: " +
						listaProdavnica.getString("Ime")
				+ " Id: " + listaProdavnica.getString("id_prodavnica"));

				PreparedStatement statement1 = konekcija.prepareStatement(
						"SELECT id_prodavnica,shifra_dodatok" + "FROM prodavnica.dodatok where id_prodanica="+idProdavnicaInt);
				
				
				ResultSet listaDodatoci = statement1.executeQuery();
				

				boolean isEmpty1 = !listaDodatoci.next();
				boolean hasData1 = !isEmpty1;
				while(hasData1){

					String dodatok= listaDodatoci.getString("shifra_dodatok");

					System.out.println("Dodatok "+dodatok);


					hasData1 = listaDodatoci.next();

				}

				hasData = listaDodatoci.next();

			}

			
			listaProdavnica.close();

			PreparedStatement statement3 = konekcija.prepareStatement(
					"insert into prodavnica.prodavnica " +
							"(id_prodavnica,website,adresa,Ime,telbroj)" +
							" values (25,'www.lady.com.mk','Lady',032384088);");



			konekcija.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		

	}
}
				