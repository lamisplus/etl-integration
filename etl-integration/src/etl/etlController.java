package etl;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;
import javafx.event.EventHandler;

public class etlController {

//    @FXML Button btnExtract, btnSourceSetup;

    @FXML
    private  void Initialize() {}

    // Open the Extraction form for mapping.
    @FXML
    private void openEtlConfig (ActionEvent evt){
        try {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("concept_mapping.fxml"));
            Parent root = fxmlLoader.load();
            Stage stage = new Stage();

            Scene scene = new Scene(root);

            stage.setTitle("Field(s) mapper");
            stage.setScene(scene);
            stage.setResizable(false);
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.showAndWait();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // This method implements the interface to create connection parameters for the source database.
    @FXML
    private  void openSourceSettings(ActionEvent evt){
        try {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("config_parameter.fxml"));
            Parent root = fxmlLoader.load();
            Stage stage = new Stage();

            Scene scene = new Scene(root);

            stage.setTitle("Source database connection setup");
            stage.setScene(scene);
            stage.setResizable(false);
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.showAndWait();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // This method implements the interface to create connection parameters for the destination database.
    @FXML
    private  void openDestinationSettings(ActionEvent evt){
        try {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("config_parameter.fxml"));
            Parent root = fxmlLoader.load();
            Stage stage = new Stage();

            Scene scene = new Scene(root);

            stage.setTitle("Destination database connection setup");
            stage.setScene(scene);
            stage.setResizable(false);
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.showAndWait();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}