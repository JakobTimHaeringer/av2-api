#/usr/bin/bash

conda activate /home/haj3st/miniconda3/envs/av2/envs/av2

echo "Creating map overview and scenario video visualisation!"

# Dataroot
dataroot='/mnt/ssd/training_data_trajectory_prediction/2024_04_24_argoverse_dataset_v2/'

# List of scenario directories
scenario_ids=(
    "021f25e2-08f6-4a43-ac82-ec2812ec7e7e/"
    "35643b98-4086-4a8b-9ea4-0a1339059881/"
    "689ba4fd-0596-4f23-841c-d9dfde7f557c/"
    "34491a64-cc0c-42a9-b788-70320284ebc5/"
    "01200e53-bdc9-4d12-b636-e073a94bc68e/"
    "00e4d383-b7a8-4412-86df-575eb0ea9a28/"
    "9ab6cb52-e211-4a5d-b6b6-6ac97cd66ee3/"
    "cdc9d2d9-23e5-4b32-aed3-918b7fab16b9/"
    "668e6666-8c2f-4a72-bab9-62e34f99fbdb/"
    "333761a7-6557-447a-b95a-635e0bcbc1a0/"
    "00078f90-71fa-454f-96ea-eef93c70d499/"
    "9a598ff4-acf8-4cb2-afa1-61f9ffc6d9ea/"
)

output_dir='/home/haj3st/av2-api/results/300h'

# Loop through the scenario directories
for dir in "${scenario_ids[@]}"
do
    full_dir="${dataroot}${dir}"
    python3 /home/haj3st/av2-api/src/generate_forecasting_scenario_visualizations.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
    python3 /home/haj3st/av2-api/src/generate_map_overview.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
done

echo "Map overview and scenario video visualisation has been created!"